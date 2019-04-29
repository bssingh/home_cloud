var express = require('express')  
var serveStatic = require('serve-static')

var staticBasePath = '.';

var app = express()

function num_files (folderPath) {
	var count = 0
	var fs = require('fs');
	count = fs.readdirSync(folderPath).length;
	return count;
}

app.get('/', function(req, res) {
	var fs = require('fs');
	var file = fs.readFileSync("head.html");
	var file1 = fs.readFileSync("tail.html");
	res.write(file);
	count = num_files("thumbs/");
	for (i = 0; i < count; i++) {
            res.write('<article class="thumb">');
	    res.write('<img class="lozad"  data-src="thumbs/' + i + '.jpg" data-index="' + i + '" /> ');
	    res.write('<img class="lozad" data-src="thumbs/' + (++i) + '.jpg" data-index="' + i + '" /> ');
	    res.write('<img class="lozad"  data-src="thumbs/' + (++i) + '.jpg" data-index="' + i + '" /> ');
	    res.write('<img class="lozad"  data-src="thumbs/' + (++i) + '.jpg" data-index="' + i + '" /> ');
	    res.write('</article>');
	}
	res.write(file1);
	res.end();
});
app.use(serveStatic(staticBasePath, {'index': false}))
app.listen(8080)  
