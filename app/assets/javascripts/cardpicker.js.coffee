(->

  query = (term, callback) ->
    $.ajax
      method: 'GET'
      url: "/query/#{term}"
      success: callback

  $.fn.extend

    addSelection: (content, card) ->
      $selection = $('<div>')
        .addClass 'selection'
        .text content
      $selection.prop card: card
      @prop('options').append $selection

    removeSelections: ->
      @prop('options').empty()
      @hide()

    nextSelection: ->
      (->
        if @selection
          @selection = @selection.next()
        unless @selection instanceof $ and @selection.length > 0
          @selection = @options.children().first()
        @options.children().removeClass 'selected'
        @selection.addClass 'selected'
        if @selection.prop 'card'
          @input.val @selection.prop('card').name
          @queryTerm = @selection.prop('card').name
      ).call @[0]

    previousSelection: ->
      (->
        if @selection
          @selection = @selection.prev()
        unless @selection instanceof $ and @selection.length > 0
          @selection = @options.children().last()
        @options.children().removeClass 'selected'
        @selection.addClass 'selected'
        if @selection.prop 'card'
          @input.val @selection.prop('card').name
          @queryTerm = @selection.prop('card').name
      ).call @[0]

    chooseSelection: ->

  $ ->

    $('.cardpicker').each ->
      $pickerBox = $('<div>')
        .addClass '.cardpicker-box'
        .css display: 'none'
      @pickerbox = $pickerBox
      $pickerBox.prop input: $(@)
      $(@).after($pickerBox)

      $options = $('<div>').addClass '.options'
      $pickerBox.prop options: $options
      $pickerBox.append $options

      $loader = $('<div>')
        .addClass '.loading'
        .css display: 'none'
        .text '...'
      $pickerBox.prop loader: $loader
      $pickerBox.append $loader

    $('.cardpicker').keydown (e) ->

      term = @value

      (->
        switch e.which
          when 9 # tab
            e.preventDefault()

            if @queryTerm is term
              $(@).nextSelection()
            else
              $(@).addSelection(term, name: term)
              $(@).nextSelection()
              $(@).show()
              @loader.show()
              @queryTerm = term
              query term, (results) =>
                @results = results
                for card in results
                  $(@).addSelection("#{card.name} (#{card.versions.length} printings)", card)
                @loader.hide()

          when 13 # enter
            e.preventDefault()
            $(@).chooseSelection()

          when 38 # up
            e.preventDefault()
            $(@).previousSelection()

          when 40 # down
            e.preventDefault()
            $(@).nextSelection()

          else
            $(@).hide()
            $(@).removeSelections()

        ).call @pickerbox[0]

).call(@)
