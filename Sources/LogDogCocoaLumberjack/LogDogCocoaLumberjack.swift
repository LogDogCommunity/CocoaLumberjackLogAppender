import LogDog
import CocoaLumberjack
import CocoaLumberjackSwiftLogBackend

public final class CocoaLumberjackAppender: LogAppender {
    
    public struct Configuration {
        /// The `DDLog` instance to use for logging.
        public let log: DDLog
        /// The level as of which log messages should be logged synchronously instead of asynchronously.
        public let syncLoggingTresholdLevel: Logger.Level
        
        public static let `default` = Configuration(
            log: DDLog.sharedInstance,
            syncLoggingTresholdLevel: .error
        )
    }
    
    public let configuration: Configuration
    
    public init(configuration: Configuration = .default) {
        self.configuration = configuration
    }
    
    public func append(_ record: LogRecord<String>) throws {
        let levelAndFlag = record.entry.level.ddLogLevelAndFlag
        
        let message = DDLogMessage(
            message: record.output,
            level: levelAndFlag.0,
            flag: levelAndFlag.1,
            context: 0,
            file: record.entry.file,
            function: record.entry.function,
            line: record.entry.line,
            tag: nil,
            options: .dontCopyMessage,
            timestamp: nil
        )
        
        configuration.log.log(
            asynchronous: record.entry.level < configuration.syncLoggingTresholdLevel,
            message: message
        )
    }
}


extension Logger.Level {
    @inlinable
    var ddLogLevelAndFlag: (DDLogLevel, DDLogFlag) {
        switch self {
        case .trace: return (.verbose, .verbose)
        case .debug: return (.debug, .debug)
        case .info, .notice: return (.info, .info)
        case .warning: return (.warning, .warning)
        case .error, .critical: return (.error, .error)
        }
    }
}
