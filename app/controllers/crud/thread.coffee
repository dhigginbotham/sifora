exports.index = (req, res) -> 
  res.send "forum " + req.forum.title + " threads"

exports.new = (req, res) -> 
  res.send "new forum " + req.forum.title + " thread"

exports.create = (req, res) -> 
  res.send "forum " + req.forum.title + " thread created"

exports.show = (req, res) -> 
  res.send "forum " + req.forum.title + " thread " + req.thread.title

exports.edit = (req, res) -> 
  res.send "editing forum " + req.forum.title + " thread " + req.thread.title

exports.load = (id, fn) -> 
  process.nextTick () ->
    fn null, 
      title: "How do you take care of ferrets?"
  
