#!/bin/bash

function diff() {
    new="Pieces/$1"
    old="oldPieces/$1"
    ksdiff --wait "$old" "$new"
}

diff FishLamp-Core
diff FishLamp-ActivityLog
diff FishLamp-Networking
diff FishLamp-Async
diff FishLamp-Encoding
diff FishLamp-Persistance
diff FishLamp-Authentication
diff FishLamp-Strings/Classes $cocoa_module/Strings
diff FishLamp-ModelObject/Classes $cocoa_module/ModelObject
diff FishLamp-Test/Classes $cocoa_module/Testing

diff FishLamp-CodeGenerator/Classes	monolith/Frameworks/CodeGenerator

