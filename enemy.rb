# coding: utf-8

class Enemy < Sprite
  def update
    self.y += rand(5)
    self.x += (2-rand(5))
    if self.y >= Window.height - self.image.height
      self.y = 0
      self.x = rand(800)
    end
  end
end