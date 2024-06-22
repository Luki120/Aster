import Foundation

private let cmdLineArgs = Array(CommandLine.arguments.dropFirst())

private let helpMessage = """
Aster - © 2023-2024 Luki120
A vanilla CLI tool to wipe the logs found under ⇝ Privacy ⇝ Analytics & Improvements ⇝ Analytics Data.
Version 0.9.0
Usage: aster <option>

Options:
	-h, -help        Prints this help message.
	-c, -count       Prints the total count of logs.
	-p, -purge       Deletes all logs.
"""

private var logsPathURL: URL {
	return URL(fileURLWithPath: "/var/mobile/Library/Logs/CrashReporter/")
}

private var logs: [String]? {
	return try? FileManager.default.contentsOfDirectory(atPath: logsPathURL.path)
}

for arg in cmdLineArgs {
	switch arg {
		case "-h", "-help": print(helpMessage)
		case "-c", "-count": print(logs?.count ?? "")
		case "-p", "-purge": cleanUp()
		default: break
	}
}

private func cleanUp() {
	guard let logs else { return }

	do {
		guard logs.count > 0 else {
			print("Directory already empty")
			exit(1)
		}

		try logs.forEach {
			try FileManager.default.removeItem(at: logsPathURL.appendingPathComponent($0))
		}

		print("Succesfully cleaned up the directory")
	}
	catch {
		print(error)
	}
}
