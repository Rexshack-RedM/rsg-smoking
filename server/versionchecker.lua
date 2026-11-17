local resource = GetCurrentResourceName()

local function printStatus(kind, message)
    local color = kind == 'success' and '^2' or '^1'
    print(('^5[%s]%s %s^7'):format(resource, color, message))
end

PerformHttpRequest('https://raw.githubusercontent.com/RexShackGaming/rex-versioncheckers/main/' .. resource .. '/version.txt', function(status, body)
    if status ~= 200 or not body then
        return printStatus('error', 'Currently unable to run a version check.')
    end

    local latest = body:gsub('%s+', '')
    local current = GetResourceMetadata(resource, 'version')

    if latest ~= current then
        printStatus('error', ('You are currently running an outdated version, please update to version %s'):format(latest))
    end
end)
