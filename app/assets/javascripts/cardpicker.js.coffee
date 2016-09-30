(->

  $ ->

    $('.cardpicker').keydown (e) ->

      if e.which is 9
        # tab
        e.preventDefault()

      if e.which is 13
        # enter
        e.preventDefault()

      if e.which is 38
        # up
        e.preventDefault()

      if e.which is 40
        # down
        e.preventDefault()

).call(@)