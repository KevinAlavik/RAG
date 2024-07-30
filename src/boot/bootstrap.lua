local logger = require("src.utils.logger");
local init = require("src.boot.init");

local function parseArgs()
    local args = arg;
    for i = 2, #args do
        local arg = args[i];
        if arg == "--verbose" or arg == "-v" then
            logger.setLevel("DEBUG");
            return;
        else
            logger.error("Bootstrap", "Invalid arg: %s", arg);
            os.exit(1, true);
        end;
    end;
    logger.setLevel("INFO");
end;

function boot()
    parseArgs();
    logger.debug("Bootstrap", "Reached boot()");
    init.initWindow();
end;

require("src.main");

return { boot = boot };
