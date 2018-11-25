//
//  ComplicationController.swift
//  ShakedIn WatchKit Extension
//
//  Created by Nafeh Shoaib on 2018-11-25.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let ComplicationCurrentEntry = "ComplicationCurrentEntry"
    let appIcon = ""
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let complicationTem: CLKComplicationTemplate?
        switch complication.family {
        case .circularSmall:
            let circularTemplate = CLKComplicationTemplateCircularSmallSimpleImage()
            circularTemplate.imageProvider = CLKImageProvider(onePieceImage: UIImage(imageLiteralResourceName: appIcon))
            complicationTem = circularTemplate
        case .graphicCircular:
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(imageLiteralResourceName: appIcon))
            complicationTem = graphicCircularTemplate
        default:
            complicationTem = nil
            break
        }
        handler(complicationTem)
    }
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
