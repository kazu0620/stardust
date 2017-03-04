import UIKit
import UserNotifications

class LocalNotificationPublisher {
    
    static func publish(withUserName userName: String, userImage: UIImage?, timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.body = "\(userName) wants to talk with you!"
        content.sound = UNNotificationSound.default()
        
        content.userInfo = ["mutable-content": 1]
        
        if let image = userImage {
            let imgUrl = self.save(image: image)!
            
            // 画像を添付
            let attachement =
                try! UNNotificationAttachment(identifier: "img", url: imgUrl, options: nil)
            content.attachments = [attachement]
        }
        
        // 5秒後に発火する UNTimeIntervalNotificationTrigger 作成、
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: false)
        
        // identifier, content, trigger から UNNotificationRequest 作成
        let request = UNNotificationRequest.init(identifier: "FiveSecondNotification", content: content, trigger: trigger)
        
        // UNUserNotificationCenter に request を追加
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    private static func save(image: UIImage) -> URL? {
        
        if let data = UIImagePNGRepresentation(image) {
            
            let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
            do {
                try data.write(to: filename)
                return filename
            } catch {
                return nil
            }
        }
        
        return nil
    }
    
    private static func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
