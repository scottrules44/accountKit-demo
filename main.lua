local accountKit = require("plugin.accountKit")
local widget = require("widget")
local json = require("json")

--functions
local showLogin
local showAccount
--

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,.5 )

local title = display.newText( "Account Kit Plugin", display.contentCenterX, 40, native.systemFontBold, 20 )

local signInGroup = display.newGroup( )
local signedInGroup = display.newGroup( )

local loginWithEmail = widget.newButton( {
	x = display.contentCenterX,
	y= display.contentCenterY-20,
	label = "Login with email",
	onRelease = function (  )
		accountKit.loginWithEmail(function ( e )
          if (e.isError ==false) then
                                  showAccount()
          end
			print( json.encode( e ) )
		end)
	end
} )
signInGroup:insert(loginWithEmail)
local loginWithPhoneNumber = widget.newButton( {
	x = display.contentCenterX ,
	y= display.contentCenterY+ 20,
	label = "Login with Phone Number",
	onRelease = function (  )
		accountKit.loginWithPhoneNumber(function ( e )
            if (e.isError ==false) then
                showAccount()
            end
			print( json.encode( e ) )
		end)
	end
} )
signInGroup:insert(loginWithPhoneNumber)

local getInfo = widget.newButton( {
x = display.contentCenterX ,
y= display.contentCenterY- 20,
label = "Get Account Info",
onRelease = function (  )
    accountKit.getInfo(function (e)
            native.showAlert( "Info", json.encode( e ),{"Ok"} )
    end)
    
end
} )
signedInGroup:insert(getInfo)

local signOut = widget.newButton( {
 x = display.contentCenterX ,
 y= display.contentCenterY+ 20,
 label = "Sign Out",
 onRelease = function (  )
    accountKit.signOut()
    showLogin()
 end
 } )
signedInGroup:insert(signOut)

signInGroup.alpha = 0
signedInGroup.alpha = 0

function showLogin()
    signInGroup.alpha = 1
    signedInGroup.alpha = 0
end
function showAccount()
    signedInGroup.alpha = 1
    signInGroup.alpha = 0
end
if (accountKit.isUserLoggedIn()== true) then
    showAccount()
else
    showLogin()
end
