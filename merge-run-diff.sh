#!/bin/bash

function diff() {
    ksdiff --wait "$1" "$2"
}

cd merge
cocoa_module="../Frameworks/Cocoa/Classes/Modules"

diff FishLamp-Core/Classes monolith/Frameworks/Core/Classes/ 
diff FishLamp-Logger/Classes monolith/Frameworks/Core/Classes/Logger
diff FishLamp-ActivityLog/Classes  $cocoa_module/ActivityLog 
diff FishLamp-Networking/Classes $cocoa_module/Network 
diff FishLamp-Async/Classes	$cocoa_module/Async
diff FishLamp-Encoding/Classes $cocoa_module/Encoding
diff FishLamp-Persistance/Classes $cocoa_module/Persistance
diff FishLamp-Authentication/Classes $cocoa_module/Authentication
diff FishLamp-Strings/Classes $cocoa_module/Strings
diff FishLamp-ModelObject/Classes $cocoa_module/ModelObject
diff FishLamp-Test/Classes $cocoa_module/Testing

diff FishLamp-CodeGenerator/Classes	monolith/Frameworks/CodeGenerator

