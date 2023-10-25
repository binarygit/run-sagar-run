ABSOLUTE_Y = 215
OBSTACLE_WIDTHS = [10, 20, 30]

def tick args
  args.state.sagar  ||= {x: 50, y: ABSOLUTE_Y, h: 40, w: 10, r: 255, g: 51, b: 51}
  args.state.obstacle ||= {x: 500, y: ABSOLUTE_Y, h: 30, w: 10}
  args.state.ground ||= {x: 0, y: 200, h: 10, w: args.grid.w}
  args.outputs.solids << [args.state.sagar, args.state.ground]
  args.outputs.solids << [args.state.obstacle]

  unless args.state.obstacle.intersect_rect? args.state.sagar
    args.state.obstacle.x -= 3

    if args.state.obstacle.x.negative?
      args.state.obstacle.x = 500
    end

    if args.state.sagar.y <= ABSOLUTE_Y
      if args.inputs.keyboard.up
        args.state.sagar.y += 80
      end
    end

    if args.state.sagar.y > ABSOLUTE_Y
      args.state.sagar.y -= 1.5
    end
  end

  add_debugger args
end

def add_debugger args
  args.outputs.debug << { x: 400, y: 400, text: "Obstacle x value is: #{args.state.obstacle.x}" }.label!
  args.outputs.debug << { x: 400, y: 500, text: "Sagar's y value is: #{args.state.sagar.y}" }.label!
end

$gtk.reset
