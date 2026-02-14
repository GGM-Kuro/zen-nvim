; extends

(function_definition
  body: (block) @function.inner) @function.outer

(class_definition
  body: (block) @class.inner) @class.outer

(if_statement) @conditional.outer
(if_statement
  consequence: (block) @conditional.inner)

(for_statement) @loop.outer
(for_statement
  body: (block) @loop.inner)

(while_statement) @loop.outer
(while_statement
  body: (block) @loop.inner)
