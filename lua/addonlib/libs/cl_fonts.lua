addonlib.font = function(name, _size, _weight)
    surface.CreateFont(name, {
        font = "Montserrat Medium",
        size = _size or 25,
        weight = _weight or 500,
    })
end