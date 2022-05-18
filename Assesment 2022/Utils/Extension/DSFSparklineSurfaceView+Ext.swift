//
//  DSFSparklineSurfaceView+Ext.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import DSFSparkline

extension DSFSparklineSurfaceView {

    public override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.setDisableActions(false)
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        CATransaction.setDisableActions(false)
    }
}
