//
//  URLValidator.swift
//  browserProject
//
//  Created by Ivana Karcelova on 10/23/19.
//  Copyright © 2019 Ivana Karcelova. All rights reserved.
//

import UIKit

class URLValidator: NSObject
{
    let webExtensions = [".com", ".org", ".net", ".edu", ".gov", ".co.uk", ".ca", ".me", ".mil", ".io"]
    let frequentWebs = ["youtube", "instagram", "pinterest", "rutgersPrep","amazon","google","facebook", "reddit","yahoo","youtube"]
    
    let rPS = "https:\\www.rutgersprep.org"
    
    var urlString = ""
    
    init(urlString: String)
    {
        super.init()
        self.urlString = urlString

    }
    
    //fun!!!
    //once we collect the string, then we evaluate what's inside of it
    public func isCorrectURLString() -> Bool
    {
        guard let url = NSURL(string: self.urlString)
        else
        {
            return false
        }
        if !UIApplication.shared.canOpenURL(url as URL)
        {
            return false
        }
        return true
    }
    
    func getCorrectURL() -> URL
      {
          let url = URL(string: "https://www.google.com")
          
          return url!
      }
    
    
    //does the urlString contain the known extensions
    //go to google - fail safe
    //fix spaces
    
    public func getSubString(_ string: String, _ from: Int, _ to: Int) -> String
    {
        let start = string.index(string.startIndex, offsetBy: from)
        let end = string.index(string.endIndex, offsetBy: to)
        
        return String(string[start..<end])
    }
    
    public func indexOf(_ string: String, _ search: String) -> Int
    {
        let stringLength = string.count
        let searchLength = search.count
        
        var x = 0
        
        while(x <= stringLength - searchLength)
        {
            let subString = self.getSubString(string, x, x + searchLength)
            if(subString == search)
            {
                return x
            }
            
            x+=1
        }
        
        return -1
    }
    
    func validateURL() -> String
    {
        let input = urlString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        var output = input
        
        if(input.contains(" "))
        {
            output = self.returnGoogleSearch()
        }
        
            
        else
        {
            for _ in frequentWebs
            {
                var x = 1
                if input == frequentWebs[x]
                {
                    output =   "https://www." + input + ".com"
                    break
                }
                x+=1
            }
          
            output = self.returnGoogleSearch()
            
            if(input.contains("."))
            {
                if(input.contains("https://www."))//if(indexOf(input, "https://www.") == 0)
                {
                    for domain in webExtensions
                    {
                        if(input.contains(domain))
                        {
                            output = input
                            print("valid page")
                            break
                        }
                    }
                }
                if (input.contains("www.www."))
                {
                    output = self.returnGoogleSearch()
                }
                    
                    
                else
                {
                    for domain in webExtensions
                    {
                        if(input.contains(domain) && input.contains("www."))
                        {
                            output = "https://" + input
                        }
                            
                        else if(input.contains(domain))
                        {
                            output = "https://www." + input
                        }
                    }
                }
            }
            
        }
        
        print(output)
        return output
    }
    
    func returnGoogleSearch() -> String
    {
        let input = urlString.trimmingCharacters(in: CharacterSet.whitespaces)
        var other = "https://www.google.com/search?q=" + input
        
        if(input.contains(" "))
        {
            other = "https://www.google.com/search?q="  +  input.replacingOccurrences(of: " ", with: "+")
        }
       
        
        return other
    }
 

    
}

//STRING METHODDDDDDD!!!!!
extension String
{
    public func getSubString(_ from: Int, _ to: Int) -> String
    {
        if(to > from && from >= 0 && from < self.count && to <= self.count)
        {
            let start = self.index(self.startIndex, offsetBy: from)
            let end = self.index(self.startIndex, offsetBy: to)
            
            return String(self[start..<end])
        }
        
        return String("")
    }
    
    public func getSubString(_ from: Int) -> String
    {
        return String(self.suffix(from))
    }
    
    public func findAllPeriods() -> [Int]
    {
        var indices = [Int]()
        
        var searchStartIndex = self.startIndex
        
        while searchStartIndex <  self.endIndex,
            let range = self.range(of: ".", range: searchStartIndex..<self.endIndex)
        {
            let index = self.distance(from: self.startIndex, to: range.lowerBound)
            
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        
        
        return indices
    }
    
}

