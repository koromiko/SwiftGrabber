import Foundation
import libGrabber

let coordinator = GrabberCoordinator()
let commandlineHelper = CommandLineHelper()

// Validate the arguments and environment variables
do {
    try commandlineHelper.parse()
} catch let e {
    print(e)
    exit(1)
}

let configuration = GrabberCoordinator.RequestConfiguration(token: commandlineHelper.parsedParameter.token,
                                                            url: commandlineHelper.parsedParameter.url)

coordinator.outputPath = commandlineHelper.parsedParameter.outputPath

coordinator.start(configuration: configuration, success: {
    print("Success")
    exit(0)
}) { (errorMessage) in
    print(errorMessage)
    exit(1)
}

RunLoop.main.run()
