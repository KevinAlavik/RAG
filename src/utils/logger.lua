local Logger = {};

Logger.LOG_LEVELS = {
    ERROR = 1;
    WARNING = 2;
    INFO = 3;
    DEBUG = 4;
};

Logger.current_level = Logger.LOG_LEVELS.INFO;

function Logger.setLevel(level)
    local level_value = Logger.LOG_LEVELS[level];
    if not level_value then
        error("Invalid log level: " .. tostring(level));
    end;
    Logger.current_level = level_value;
end;

function Logger.log(level, caller, format, ...)
    local level_value = Logger.LOG_LEVELS[level];
    if not level_value then
        error("Invalid log level: " .. tostring(level));
    end;
    if level_value <= Logger.current_level then
        local message = string.format(format, ...);
        print(string.format("%s [%s] ==> %s", level, caller, message));
    end;
end;

function Logger.error(caller, format, ...)
    Logger.log("ERROR", caller, format, ...);
end;

function Logger.warning(caller, format, ...)
    Logger.log("WARNING", caller, format, ...);
end;

function Logger.info(caller, format, ...)
    Logger.log("INFO", caller, format, ...);
end;

function Logger.debug(caller, format, ...)
    Logger.log("DEBUG", caller, format, ...);
end;

return Logger;
