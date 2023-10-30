ABSOLUTE_Y = 215
OBSTACLE_WIDTHS = [10, 20, 30]

def tick args
  args.state.start ||= false

  if args.state.start
    paint args
  else
    display_new_game_screen args
  end
end

def paint(args)
  args.state.sagar  ||= {x: 50, y: ABSOLUTE_Y, h: 40, w: 10, r: 255, g: 51, b: 51}
  args.state.obstacle ||= {x: 500, y: ABSOLUTE_Y, h: 30, w: 10}
  args.state.ground ||= {x: 0, y: 200, h: 10, w: args.grid.w}
  args.outputs.solids << [args.state.sagar, args.state.ground]
  args.outputs.solids << [args.state.obstacle]

  if game_over? args
    puts 'hello'
  else
    handle_player_movement   args
    handle_obstacle_creation args
  end

  add_debugger args
end

def handle_obstacle_creation(args)
  args.state.obstacle.x -= 3

  if args.state.obstacle.x.negative?
    args.state.obstacle.x = 500
  end
end

def handle_player_movement(args)
  if args.state.sagar.y <= ABSOLUTE_Y
    if args.inputs.keyboard.up
      args.state.sagar.y += 80
    end
  end

  if args.state.sagar.y > ABSOLUTE_Y
    args.state.sagar.y -= 1.5
  end
end

def game_over?(args)
  args.state.obstacle.intersect_rect? args.state.sagar
end

def display_new_game_screen(args)
  args.outputs.labels << {x: 500, y: 500, size_enum: 3, text: 'Run Sagar Run'}
  args.outputs.lines  << {x: 500, y: 470, h: 0, w: 160}
  #args.outputs.labels << {x: 430, y: 450, text: 'Jump over obstacles using the up arrow.'}
  #args.outputs.labels << {x: 430, y: 420, text: 'Eat biscuits to increase score.'}
  args.outputs.labels << {x: 450, y: 450, text: 'Press ↑ (up arrow) to start.'}

  if args.inputs.up
    args.state.start = true
  end
end

def add_debugger args
  args.outputs.debug << { x: 400, y: 400, text: "Obstacle x value is: #{args.state.obstacle.x}" }.label!
  args.outputs.debug << { x: 400, y: 500, text: "Sagar's y value is: #{args.state.sagar.y}" }.label!
end

$gtk.reset
