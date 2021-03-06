class Course
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :institution, :type => Array
  field :code, :type => String, :required => true
  field :name, :type => String, :required => true
  field :section, :type => String, :default => '01'
  field :teacher, :type => String
  field :assistant, :type => String
  field :created_by, :type => String
  field :students, :type => Array, :default => []
  field :request, :type => Array, :default => []


  def users_request
    User.where(:id.in request)
  end

  def users_students
    User.where(:id.in students)
  end

  def users_teacher
    User.where(:id => teacher)
  end

  def users_assistant
    User.where(:id => assistant)
  end

  def select_form
    "#{name} #{code} - #{section}"
  end

end
