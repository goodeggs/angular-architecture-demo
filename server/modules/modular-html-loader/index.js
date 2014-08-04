module.exports = function(source) {
  this.cacheable();
  console.log('THIS', this);
  console.log('ARGUMENTS', arguments);
  console.log('SOURCE', source);
  console.log('__dirname', __dirname)
  return source;
};
