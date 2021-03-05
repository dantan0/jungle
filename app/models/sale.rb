class Sale < ActiveRecord::Base

  def self.active
    where("starts_on <= ? AND ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    return self.ends_on < Date.current
  end

  def upcoming?
    return self.starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end
end
