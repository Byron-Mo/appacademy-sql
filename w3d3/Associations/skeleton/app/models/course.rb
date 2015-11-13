class Course < ActiveRecord::Base
  has_many :enrollments,
    foreign_key: :course_id,
    primary_key: :id,
    class_name: "Enrollment"

  has_many :students,
    through: :enrollments,
    source: :student

  belongs_to :prereq,
    foreign_key: :prereq_id,
    primary_key: :id,
    class_name: "Course"

  belongs_to :instructor,
    foreign_key: :instructor_id,
    primary_key: :id,
    class_name: "User"
end
