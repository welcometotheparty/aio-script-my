-- name = "tastts"
-- description = "Current Bitcoin psdo)"
-- type = "widget"
-- author = "Grigory"
-- version = "1.0"




-- local http = require("socket.http")
-- local ltn12 = require("ltn12")
-- local json = require("json")

local main_url = "https://mnkkk-grigory22211.amvera.io/"
local token = "D5Z9nQwsugtxxUXD27zey_PHcVU31tfCXckZXbd7kfTCj2yezQSkt6LjTnYY"

function get_user_info_id()
  local url = main_url .. '/users/tokens/info'
  local method = 'GET'
  local payload = {}
  local resp = send_request(url, method, token, payload)
  -- local table_size = #resp
  -- print("The table has [" .. table_size .. "] items")
  -- Получаю первый элемент таблицы
  local str = (resp[1])
  local decodedJson = json:decode(str)
  local id = decodedJson.id
  return id 
end

function add_task()
  local url = main_url .. "/tasks"
  local method = 'POST'
  local payload = {
    user_id = get_user_info_id(), 
    title = 'helloworld222111',
    description = 'desc test'
  } 
  local result = send_request(url, method, token, payload)
end

function get_tasks()
  local url = main_url .. "/tasks"
  local method = 'GET'
  local payload = {
    user_id = get_user_info_id()
  } 
  local result = send_request(url, method, token, payload)
  return result

end

function send_request(url, method, token, payload)
  local payload = json:encode (payload)
  local response_body = {}
  local res, code, response_headers = http.request{
    url = url,
    method = method,
    headers = {
      ["Authorization"] = "Bearer " .. token,
      ["Content-Type"] = "application/json"
    },
    source = ltn12.source.string(payload),
    sink = ltn12.sink.table(response_body)
  }

  if code == 200 or code == 201 then
    return response_body
  else
    print("Failed to make request. HTTP code: " .. code)
  end
end

-- r = get_tasks()


-- for key, val in pairs(r) do
--   print(val)
-- end

function aio_get_info()
  local url = main_url .. '/users/tokens/info'
  local payload = {}
  http:set_headers{ "Authorization: Bearer "..token }
  http:get(url)
end

function on_network_result(result, code)
  if code >= 200 and code < 300 then

    local str = (result[1])
    local decodedJson = json:decode(str)
    local id = decodedJson.id
    ui:show_text("Us ID is "..id)
  
      
  end
end

function on_resume()
  aio_get_info()
end
