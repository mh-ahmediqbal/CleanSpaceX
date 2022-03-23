//
//  rocketTableViewCell.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/19/21.
//

import UIKit
import Kingfisher

final class RocketsCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFirstFlight: UILabel!
    @IBOutlet weak var labelCostPerLaunch: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var imageViewRocket: UIImageView!
    
    func setupCell(rocket: Rocket){
        labelName.text = rocket.rocket_name
        labelFirstFlight.text = rocket.first_flight
        labelCostPerLaunch.text = "$\(GeneralUtility.getFormattedMoney(money: "\(rocket.cost_per_launch ?? 0)", locale: "", isPrefix: .none, rounding: 0))"
        labelCountry.text = rocket.country
        imageViewRocket.image = UIImage(named: "")
        let url = URL(string: rocket.flickr_images?[0] ?? "")
        let processor = DownsamplingImageProcessor(size: imageViewRocket.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageViewRocket.kf.indicatorType = .activity
        imageViewRocket.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
