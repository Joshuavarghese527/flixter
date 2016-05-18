class Section < ActiveRecord::Base
  belongs_to :course
  has_many :lessons

  include RankedModel
  ranks :row_order_position, :with_same => :course_id

  def next_section
    section = course.sections.where("row_order > ?", self.row_order).rank(:row_order_position).first
      if lesson.blank? && section.next_section
          return section.next_section.lessons.rank(:row_order_position).first
      end

    return section
  end
end