module ApplicationHelper
  def full_title(name = '')
    base_title = 'RUNTEQ BOARD APP'
    if name.empty?
      base_title
    else
      name + ' | ' + base_title
    end
  end
end
