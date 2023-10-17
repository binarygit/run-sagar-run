ABSOLUTE_Y = 215
def tick args
  args.state.sagar  ||= {x: 50, y: ABSOLUTE_Y, h: 40, w: 10, r: 255, g: 51, b: 51}
  args.state.ground ||= {x: 0, y: 200, h: 10, w: args.grid.w}
  args.outputs.solids << [args.state.sagar, args.state.ground]

  if args.state.sagar.y == ABSOLUTE_Y
    if args.inputs.keyboard.up
      args.state.sagar.y += 60
    end
  end

  unless args.state.sagar.y == ABSOLUTE_Y
    args.state.sagar.y -= 2
  end
end

#$gtk.reset
