class Profile
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :user
  attr_writer :income

  def save
    user.demographics.destroy_all
    
    demographics[:race].each do |v|
      user.demographics.create(key: 1, value: v)
    end

    user.demographics.create(key: 2, value: demographics[:income])
  end

  def income
    val = user.demographics.find_by(key: 2).try(:value).to_i

    val > 0 ? val : nil
  end

  def income=(number_field)
    demographics[:income] = number_field.to_i
  end

  def race
    user.demographics.where(key: 1).pluck(:value).join("\n")
  end

  def race=(textarea)
    textarea.split("\n").each do |r|
      (demographics[:race] << r.chomp) if !r.chomp.blank?
    end
  end

  def demographics
    @demographics ||= {
      race: [],
      income: nil
    }
  end
end