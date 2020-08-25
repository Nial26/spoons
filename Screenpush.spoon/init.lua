

ScreenPush = {}

ScreenPush.APP_NAME = 'Screenpush'
ScreenPush.IMGUR_URL = 'https://api.imgur.com/3/upload'
ScreenPush.IMGUR_CLIENT_ID = ''


-- split a string From https://gist.github.com/jaredallard/ddb152179831dd23b230
function string:split(delimiter)
    local result = { }
    local from  = 1
    local delim_from, delim_to = string.find( self, delimiter, from  )
    while delim_from do
      table.insert( result, string.sub( self, from , delim_from-1 ) )
      from  = delim_to + 1
      delim_from, delim_to = string.find( self, delimiter, from  )
    end
    table.insert( result, string.sub( self, from  ) )
    return result
  end

function ScreenPush:uploadImageToImgur(image)

    local uploadUrl = ScreenPush.IMGUR_URL..'/?client_id='..ScreenPush.IMGUR_CLIENT_ID

    local base64URLString = image:encodeAsURLString()
    local base64data = base64URLString:split(',')[2]

    local dataPayload = 'type=base64&image='..hs.http.encodeForQuery(base64data)

    local status, response, headers = hs.http.post(uploadUrl, dataPayload)

    if status == 200 then
        local resp = hs.json.decode(response)
        local linkUrl = resp['data']['link']
        return linkUrl
    end

end

function ScreenPush:screenPush()
    local image = hs.pasteboard.readImage()
    if image ~= nil then
        local uploadLink = ScreenPush:uploadImageToImgur(image)
        if uploadLink ~= nil then
            hs.pasteboard.setContents(uploadLink)
            hs.notify.show(ScreenPush.APP_NAME, "Public screenshot link copied to Clipboard!", uploadLink)
        else
            hs.notify.show(ScreenPush.APP_NAME, "Something went wrong ☹️", "Check the config key and Please try again!")
        end
    else
        hs.notify.show(ScreenPush.APP_NAME, "No Image in Clipboard", "Take a screenshot before using Screenpush")
    end
end

function ScreenPush:bindHotkeys(mapping)
    hs.hotkey.bindSpec(mapping['Screenpush'], function()
        self.screenPush()
    end)
end



return ScreenPush