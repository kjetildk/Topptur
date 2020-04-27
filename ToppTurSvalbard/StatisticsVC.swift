//
//  StatisticsVC.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 05.07.15.
//  Copyright (c) 2015 publisoft. All rights reserved.
//

import UIKit
import JBChart

class StatisticsVC: UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource {

    @IBOutlet weak var barChart: JBBarChartView!
    @IBOutlet weak var informationLabel: UILabel!
    
    var chartLegend = ["Meg","Galdhøpiggen","Mount Everest"]
    var chartData = [100,2469,8848]
    
    var mountEverest = 8848
    var galdhoepiggen = 2469
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //bar chart setup
        //barChart.backgroundColor = UIColor.whiteColor() //darkGrayColor()
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = 8848
        
        chartData[0] = self.total
        
        barChart.reloadData()
        
        barChart.setState(.Collapsed, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // to-do add footer and header
        let footerView = UIView(frame: CGRectMake(0, 0, barChart.frame.width, 16))
        
        let length = barChart.bounds.width/CGFloat(chartData.count)
        var offset:CGFloat = 0.0
        
        for index in 0...chartData.count-1
        {
            let footer = UILabel(frame: CGRectMake(offset, 0, length, 16))
            footer.textColor = UIColor.blackColor()
            footer.text = "\(chartLegend[index])"
            footer.textAlignment = NSTextAlignment.Center
            footer.font = UIFont(name: footer.font.fontName, size: 11)
            
            footerView.addSubview(footer)
        
            offset = length + offset
        }
        
        /*var header = UILabel(frame: CGRectMake(0, 0, barChart.frame.width, 50))
        header.textColor = UIColor.blackColor()
        header.font = UIFont.systemFontOfSize(24)
        header.text = "Weather: San Jose, CA"
        header.textAlignment = NSTextAlignment.Center
        header.backgroundColor = UIColor.greenColor()*/
        
        barChart.footerView = footerView
        //barChart.headerView = header

        //our code
        barChart.reloadData()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        hideChart()
    }
    
    func hideChart(){
        barChart.setState(.Collapsed, animated: true)
    }
    
    func showChart() {
        barChart.setState(.Expanded, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: JBbarChartView
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        var color = UIColor.lightGrayColor()
        
        switch(index){
        case 0: color = UIColor(red: CGFloat(83) / 255.0, green: CGFloat(215) / 255.0, blue: CGFloat(105) / 255.0, alpha: CGFloat(1))
        case 1: color = UIColor.lightGrayColor()
        case 2: color = UIColor.darkGrayColor()
        default:
            color = UIColor.lightGrayColor()
        }
        
        return color
    }
    
    func barChartView(barChartView: JBBarChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.darkGrayColor()
    }
    
    func barChartView(barChartView: JBBarChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt) {
        let data = chartData[Int(index)]
        _ = chartLegend[Int(index)]
        
        informationLabel.text = "\(data) " + NSLocalizedString("SUMMIT_HEIGHT",comment:"m")
    }
    
    func didDeselectBarChartView(barChartView: JBBarChartView!) {
        informationLabel.text = ""
    }
    
    func barChartView(barChartView: JBBarChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0)
        {
            return UIColor.lightGrayColor()// greenColor()
        }
        
        return UIColor.lightGrayColor()
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
