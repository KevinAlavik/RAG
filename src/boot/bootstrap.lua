local init = require("src.boot.init");

function boot()
    init.initWindow();
end

require("src.main");

return { boot = boot };