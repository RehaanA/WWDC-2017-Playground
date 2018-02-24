//
//  KMSegmentedControl.swift
//  KMSegmentedControl
//
//  Created by Kamil Mazurek on 31/05/16.
//  Copyright © 2016 KamilMazurek. All rights reserved.
//

import UIKit

public protocol KMSegmentedControlDelegate: class {
  func KMSegmentedControlItemSelected(item: UIButton)
}

@IBDesignable public class KMSegmentedControl: UIView {

  public enum UIElement {
    case HighlightedView
    case SelectorLine
  }

  public weak var delegate: KMSegmentedControlDelegate?

  // MARK : Private Variables

  private var buttons = [UIButton]()

  private var selectedItem: UIButton?

  private var selectedTitleColor: UIColor?
  private var unSelectedTitleColor: UIColor?

  private var seperatorLines = [UIView]()

  private var highlightedView = UIView()
  private var selectorLine = UIView()

  private var showSeperatorLines: Bool = true
  private var showHighlightedView: Bool = true

  private var label = UILabel()

  // MARK : Customization Properties

  public var KMFontSize: CGFloat = 14 {
    didSet {
      setFont(size: KMFontSize)
    }
  }

  @IBInspectable public var KMSelectedItemColor: UIColor? {
    didSet {
      self.selectedItem?.backgroundColor = KMSelectedItemColor
    }
  }

  @IBInspectable public var KMBorderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = KMBorderWidth
    }
  }

  @IBInspectable public var KMBorderColor: UIColor? {
    didSet {
      self.layer.borderColor = KMBorderColor?.cgColor
    }
  }

  @IBInspectable public var KMBackgroundColor: UIColor? {
    didSet {
      self.backgroundColor = KMBackgroundColor
    }
  }

  @IBInspectable public var KMCornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = KMCornerRadius
      self.layer.masksToBounds = true
    }
  }

  @IBInspectable public var KMSelectedTitleColor: UIColor? {
    didSet {
      self.selectedTitleColor = KMSelectedTitleColor
    }
  }

  @IBInspectable public var KMUnSelectedTitleColor: UIColor? {
    didSet {
      self.unSelectedTitleColor = KMUnSelectedTitleColor
    }
  }

  @IBInspectable public var KMSelectorLineColor: UIColor? {
    didSet {
      selectorLine.backgroundColor = KMSelectorLineColor
    }
  }

  @IBInspectable public var KMHighlightedViewColor: UIColor? {
    didSet {
      highlightedView.backgroundColor = KMHighlightedViewColor
    }
  }

  public var items: [String] = ["Banana", "Apple"] {
    didSet {
      setupKMSegmentedControl()
    }
  }

	public var images: [String] = [] {
		didSet {
			setupKMSegmentedControl()
		}
	}

	public var placeImageAboveTitle: Bool = false {
		didSet {
			setupKMSegmentedControl()
		}
	}

  public var KMShowSeperatorLines: Bool? {
    didSet {
      showSeperatorLines = KMShowSeperatorLines!
      setupSeperatorLines()
    }
  }

  public var KMShowHighlightedView: Bool? {
    didSet {
      showHighlightedView = KMShowHighlightedView!
    }
  }

  public var UIElements: [UIElement] = [.HighlightedView, .SelectorLine] {
    didSet {
      setupKMSegmentedControl()
    }
  }

  // MARK : Initialitation

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupKMSegmentedControl()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupKMSegmentedControl()
  }

  // MARK : Setup

  override public func prepareForInterfaceBuilder() {
    items = ["First", "Second", "Third"]
    layoutIfNeeded()
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    var selectFrame = selectedItem!.frame
    if UIElements.contains(.SelectorLine) {
      let newWidth = selectFrame.width + 0.5
      selectFrame.size.width = newWidth
      selectFrame.size.height = 4.0
      selectFrame.origin.y = (selectedItem?.frame.height)! - 4
      selectorLine.frame = selectFrame
      selectorLine.backgroundColor = KMSelectorLineColor
      addSubview(selectorLine)
    }

    if UIElements.contains(.HighlightedView) {
      highlightedView.frame = CGRect(x: 0, y: 0, width: selectedItem!.frame.width - 4.0, height: selectedItem!.frame.height - 4.0)
      highlightedView.center = selectedItem!.center
      highlightedView.backgroundColor = KMHighlightedViewColor
      highlightedView.layer.cornerRadius = KMCornerRadius
      insertSubview(highlightedView, at: 0)
    }

    if showSeperatorLines {
      setupSeperatorLines()
    }
  }

  private func setupSeperatorLines() {

    if !showSeperatorLines {
      return
    } else {
      for line in seperatorLines {
        line.removeFromSuperview()
      }
      seperatorLines.removeAll()
      for index in 0..<buttons.count {
        let xPos: CGFloat = buttons[index].frame.width * CGFloat(index)
        let line = UIView(frame: CGRect(x: (buttons[index].frame.width) * CGFloat(index), y: 0, width: KMBorderWidth, height: self.frame.height))
        line.center.x = xPos
        line.backgroundColor = KMBorderColor
        seperatorLines.append(line)
        addSubview(line)
      }
    }
    print(seperatorLines.count)
  }

  private func setupKMSegmentedControl() {

    for button in buttons {
      button.removeFromSuperview()
    }
    buttons.removeAll(keepingCapacity: true)

    for i in 0...items.count - 1  {
      var button = UIButton()
      button.tag = i
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(items[i], for: .normal)
      button.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 14)
      button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchDown)
      button.setTitleColor(i == 0 ? KMSelectedTitleColor : KMUnSelectedTitleColor, for: .normal)
			if !images.isEmpty {
				setImage(named: images[i], button: &button)
				if placeImageAboveTitle {
					setupButton(button: &button)
				}
			}
      buttons.append(button)
      addSubview(button)
    }

    if KMSelectedItemColor != nil {
      buttons[0].backgroundColor = KMSelectedItemColor
    } else {
      buttons[0].backgroundColor = self.backgroundColor?.darkerColor()
    }
    selectedItem = buttons[0]

    var prevButton: UIButton? = nil
    for index in 0..<buttons.count {
      var constraints: [NSLayoutConstraint] = []
      let button = buttons[index]
      if index < buttons.count - 1 {
        constraints.append(button.widthAnchor.constraint(equalTo: buttons[index + 1].widthAnchor))
      }
      constraints.append(button.topAnchor.constraint(equalTo: self.topAnchor))
      constraints.append(button.bottomAnchor.constraint(equalTo: self.bottomAnchor))
      if index == 0 {
        constraints.append(button.leadingAnchor.constraint(equalTo: self.leadingAnchor))
      } else if index == buttons.count - 1 {
        constraints.append(button.trailingAnchor.constraint(equalTo: self.trailingAnchor))
      }
      if prevButton != nil {
        constraints.append(button.leadingAnchor.constraint(equalTo: (prevButton?.trailingAnchor)!))
      }
      NSLayoutConstraint.activate(constraints)
      prevButton = button
    }
  }

  // MARK : Action Handling

  func didTapButton(sender: UIButton) {
    selectedItem?.backgroundColor = self.backgroundColor
    selectedItem?.isEnabled = true
    selectedItem?.setTitleColor(KMUnSelectedTitleColor, for: .normal)
    selectedItem = sender

    if KMSelectedItemColor != nil {
      sender.backgroundColor = KMSelectedItemColor
    } else {
      sender.backgroundColor = self.backgroundColor?.darkerColor()
    }

    if UIElements.contains(.SelectorLine) {
      UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
        self.selectorLine.frame = CGRect(x: CGFloat(sender.frame.width) * CGFloat(sender.tag) , y: sender.frame.height - 4.0, width: CGFloat(sender.frame.width), height:4.0)
        }, completion: nil)
    }

    if UIElements.contains(.HighlightedView) {
      UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: . curveEaseOut, animations: {
        self.highlightedView.frame = CGRect(x: 0, y: 0, width: sender.frame.width - 4.0, height: sender.frame.height - 4.0)
        self.highlightedView.center = sender.center
        }, completion: nil)
    }

    sender.isEnabled = false
    sender.setTitleColor(KMSelectedTitleColor, for: .normal)
		if !images.isEmpty {
			selectedItem!.setImage(UIImage(named: images[sender.tag]), for: .highlighted)
			selectedItem!.setImage(UIImage(named: images[sender.tag]), for: .disabled)
		}
    delegate?.KMSegmentedControlItemSelected(item: sender)
  }

  // MARK : Helper Methods

  func setFont(size: CGFloat) {
    for item in buttons {
      item.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: size)
    }
  }

	private func setImage(named: String, button: inout UIButton) {
		let image = UIImage(named: named)
		image?.withRenderingMode(.alwaysOriginal)
		button.setImage(image, for: .normal)
	}

	private func setupButton( button: inout UIButton) {
		let spacing: CGFloat = 6.0
		let imageSize: CGSize = button.imageView!.image!.size
		button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
		let labelString = NSString(string: button.titleLabel!.text!)
		let titleSize = labelString.size(attributes: [NSFontAttributeName: button.titleLabel!.font])
		button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
	}
}
