  # == Schema Information
  #
  # Table name: solutions
  #
  #  contest_id       :integer
  #  created_at       :datetime         not null
  #  file_size        :decimal(, )
  #  id               :integer          not null, primary key
  #  language         :string(255)
  #  memory_used      :decimal(, )
  #  output           :string(255)
  #  problem_id       :integer
  #  run_time         :decimal(, )
  #  solved_time      :decimal(, )
  #  src_content_type :string(255)
  #  src_file_name    :string(255)
  #  src_file_size    :integer
  #  src_updated_at   :datetime
  #  state_id         :integer
  #  updated_at       :datetime         not null
  #  user_id          :integer
  #


  class Solution < ActiveRecord::Base
    include ScoreGenerator
    attr_accessible :language, :output, :src, :user_id, :problem_id,
    				  :solved_time, :state_id, :contest_id, :memory_used, :run_time, :file_size,
              :run_time_score, :file_size_score, :score

    belongs_to :state
    belongs_to :problem 
    belongs_to :contest
    belongs_to :user
    has_attached_file :src#, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  #  validates_format_of :src, :with => %r{\.(cpp|java)$}i, :message => "file must be in .cpp or .java format"

    #scope :solved, where("solved_time is not null")
    scope :solved, joins(:state).where("acronym = 'AC'")


    def judge
      solution = self
      puts "judging solution #{solution.id} from team: #{solution.user.username}"
      src = solution.src.path
      input = solution.problem.input.path
      time = -1

      if solution.language == 'Java'
        path = src.gsub(".java", "")
        compile = `javac #{src}`
        src = src.gsub(solution.src_file_name, "")
        beginning = Time.now
        run = solution.src_file_name.gsub(".java", "")
        return if CE?("#{src}#{run}.class")     # check Compilation error
        out = "error"
        begin
          Timeout::timeout(solution.problem.time) {
          out = `java -classpath #{src} #{run} < #{input}`
        }
          
        rescue Timeout::Error => te
          puts "Time Limit Exceeded : #{te}".red
          solution.state = State.find_by_acronym('TL') #Time Limit Exceeded
          solution.solved_time = nil
          solution.save
  #        PrivatePub.publish_to "/contest/#{self.contest.id}/user/#{self.user.id}", solutionToJson
          return
        end

        #puts "**************".red
        #execLine = "java -classpath #{@src} #{run} < #{@input}"
        #puts execLine.green
        ending = Time.now
        #@timeOf = "Time elapsed #{(ending - beginning).to_f} seconds"
        time = ending - beginning
        write(out, path +'.out')
        


      else #@solution.language == 'C++'

        path = src.gsub(solution.src_file_name, "")+solution.src_file_name.gsub(".cpp","")
        compile = `g++ #{src} -o #{path}`

        return if CE?("#{path}")     # check Compilation error
        out = "error"
        beginning = Time.now

        begin
          Timeout::timeout(solution.problem.time) {
          out = `#{path} < #{input}` 
        }
          
        rescue Timeout::Error => te
          
          puts "Time Limit Exceeded : #{te}".red
          solution.state = State.find_by_acronym('TL') #Time Limit Exceeded
          solution.solved_time = nil
          solution.save
          PrivatePub.publish_to "/contest/#{self.contest.id}/user/#{self.user.id}", solutionToJson
          return
        end
        
        #execLine = "#{@path} < #{@input}"
        #puts execLine.green
        ending = Time.now
        #@timeOf = "Time elapsed #{ending - beginning} seconds"
        time = ending - beginning
        write(out,path +'.out')

      end


        userOutput = path +'.out'
        adminOutput =solution.problem.output.path
        equals = equals?(solution.problem.output.path,path +'.out')

        if equals
          solution.state = State.find_by_acronym('AC') # Accepted
          solution.solved_time = Time.now-solution.contest.start_date # calcule of the solved time

      
        else
          solution.state = State.find_by_acronym('WA') #Wrong Answer
          solution.solved_time = nil
          solution.save
      #    callPrivatePub
          return
        end      
        solution.save

        if (userOutput and adminOutput)
          feedback = `diff -Z #{userOutput} #{adminOutput}` 
         #puts "diff -Z #{@userOutput} #{@adminOutput}"
         # puts "******************"
         # puts @feedback
         # puts "******************"
        end 
        #PrivatePub.publish_to "/contest/#{solution.contest.id}/user/#{solution.user.id}", solutionToJson
     #   callPrivatePub
        
        
        puts "Finalize judging solution #{solution.id} from team: #{solution.user.username}"
    end
 end

    def CE?(file)
      
     # puts "cheking...#{file}".green
      

       if  File.exist?(file) 
         return false 
        else 
          self.state = State.find_by_acronym('CE') 
          self.solved_time = nil
          self.save
    #      callPrivatePub
          return true        
       end
    end

    def write(output, path)
      File.open(path, 'w') do |f|
      f.puts output
    end

  #  def find_Memory(solution)
      #Not implemented yet...
  #    return -1
  #  end

    def equals?(userOutput, adminOutput)
        
      # FileUtils.compare_file(userOuput ,adminOuput) 
      result = `diff -Z #{userOutput} #{adminOutput}` # -Z
      return true if result.length==0 # length==0 means no differences
    end

    def solutionToJson
      json ={id: self.id, state: self.state.acronym, run_time: self.run_time, file_size: self.file_size, state_name: self.state.name }
      return json
    end

    def callPrivatePub

       PrivatePub.publish_to "/contest/#{self.contest.id}/user/#{self.user.id}", solutionToJson
      
    end

    
  end