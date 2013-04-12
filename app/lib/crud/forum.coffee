exports.index = (req, res) ->
  res.send("forum index")

exports.new = (req, res) ->
  res.send("new forum")

exports.create = (req, res) ->
  res.send("create forum")

exports.show = (req, res) ->
  res.send("show forum " + req.forum.title)

exports.edit = (req, res) ->
  res.send("edit forum " + req.forum.title)

exports.update = (req, res) ->
  res.send("update forum " + req.forum.title)

exports.destroy = (req, res) ->
  res.send("destroy forum " + req.forum.title)

exports.load = (id, fn) ->
  process.nextTick () ->
    fn null, 
      title: "Ferrets"