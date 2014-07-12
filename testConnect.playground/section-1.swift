// Playground - noun: a place where people can play

import Cocoa
func connect(username: String, password: String){
    var request = NSMutableURLRequest(URL: NSURL(string: "http://54.191.143.176:4568/login"))
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    
    var params = ["username":username, "password":password] as Dictionary
    
    var err: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        println("Response: \(response)")
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
        
        if(err) {
            println(err!.localizedDescription)
        }
        else {
            var success = json["success"] as? Int
            println("Succes: \(success)")
        }
        })
    
    task.resume()
}
connect("fuckit", "yolo")
