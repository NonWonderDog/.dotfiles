; extends

((comment) @comment.documentation
  (#match? @comment.documentation "^///"))

((comment) @comment.documentation
  (#match? @comment.documentation "^//!"))
