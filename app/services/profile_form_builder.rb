class ProfileFormBuilder < ActionView::Helpers::FormBuilder
  # def text_field(attribute, options={})
  #   label(attribute) + super
  # end

  def income_field
    fields_for :demographics, demographics.income do |d|
      d.hidden_field :key, value: :income
      d.number_field :value
    end
  end

  def race_fields
    fields = fields_for :demographics, demographics.race do |d|
      d.hidden_field :key, value: :race
      d.text_field :value
    end

    add_link = @template.link_to "+", '#'

    return (fields + add_link)
  end

  private

  def demographics
    @demographics ||= object.demographics
  end
end