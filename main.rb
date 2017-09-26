# coding: utf-8
require 'dxruby'

class Field
  @@overflag=false
  def gameover?
    @@overflag
  end
  def gameover! flag=true
    @@overflag = flag
  end
end
field = Field.new

require_relative 'player'
require_relative 'enemy'

Window.width  = 800
Window.height = 600

player_img = Image.load("player.png")
player_img.setColorKey([0, 0, 0])

enemy_img = Image.load("enemy.png")
enemy_img.setColorKey([0, 0, 0])

player = Player.new(400, 500, player_img)

enemies = []
15.times do
  enemies << Enemy.new(rand(800), rand(200), enemy_img)
end

font = Font.new(30)

time=0

startflag=0

Window.loop {
  break if Input.keyPush?(K_ESCAPE)

  if startflag==0
  Window.draw_font(220, 240, "Enterキーを押してスタート", font)
  end

  startflag=1 if Input.keyPush?(K_RETURN)

  if startflag==1
  
   Sprite.update(enemies)
   Sprite.draw(enemies)

   player.update
   player.draw

   Window.draw_font(0, 0, "#{(time/60)}", font)
   
   if field.gameover?
    Window.draw_font(220, 240, "Game Over", font)
    Window.draw_font(220, 340, "今回のスコア:#{time/60}秒", font)
   else
    time+=1
   end

   # 当たり判定
   Sprite.check(enemies,player)

  end
}