-- this plugin interacts with buffline, which by default scopes all files to a global selection,
-- change changes the behavior to group buffers by native tabs
-- our buffline display of buffers is affected as well as the "find buffers" functionality (from snacks?)
-- see https://github.com/akinsho/bufferline.nvim#how-do-i-see-only-buffers-per-tab
return {
  "tiagovla/scope.nvim",
  config = true,
}
