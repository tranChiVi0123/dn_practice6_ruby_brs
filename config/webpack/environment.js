const { environment } = require('@rails/webpacker')
const webpack = required('webpack')
environment.plugins.append('Provide',
  new webpack.PovidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)
module.exports = environment
