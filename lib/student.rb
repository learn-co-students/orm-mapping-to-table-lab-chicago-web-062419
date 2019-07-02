#3. Lastly, you'll create a method that both creates a new instance of the student class and then saves it to the database.


class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade, id = nil) # 2 attributes : name, grade.
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table #1. build a .create method(class)
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table 
    sql = <<-SQL
    DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(sql)
  end

  def save #2. build a #save method(instance method)
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)  
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    #need to grab the ID of the last inserted row, SELECT?
    #i.e. the row you just inserted into the database, 
    #and assign it to the be the value of the @id attribute of the given instance. @id = ?

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end




# Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]