class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_teacher_or_enrolled_user

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
  #can add another layer here if I want super users (such as paid vs free)
  def require_teacher_or_enrolled_user
    current_course = current_lesson.section.course
    redirect_to course_path(current_course), alert: "Enroll to access the lessons!" unless current_user.enrolled_in?(current_course) || current_user.courses.include?(current_course)
  end

end
