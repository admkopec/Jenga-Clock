// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

//
//  MultiPickerView.swift
//  Jenga-Clock
//
//  Created by Adam Kopeć on 22/04/2022.
//

import SwiftUI

#if !SKIP
public struct MultiPickerView: UIViewRepresentable {
    private var data = [[String]]()
    private var selections = [Binding<Int>]()
    
    //makeCoordinator()
    public func makeCoordinator() -> MultiPickerView.Coordinator {
        Coordinator(self)
    }
    
    //makeUIView(context:)
    public func makeUIView(context: UIViewRepresentableContext<MultiPickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    //updateUIView(_:context:)
    public func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<MultiPickerView>) {
        for i in 0..<self.selections.count {
            view.selectRow(self.selections[i].wrappedValue, inComponent: i, animated: false)
        }
    }
    
    public init(data: [String]..., selection: Binding<Int>...) {
        guard data.count == selection.count else { return }
        self.data = data
        self.selections = selection
    }
    
    public class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: MultiPickerView
        
        //init(_:)
        init(_ pickerView: MultiPickerView) {
            self.parent = pickerView
        }
        
        //numberOfComponents(in:)
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        //pickerView(_:numberOfRowsInComponent:)
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        //pickerView(_:titleForRow:forComponent:)
        public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }
        
        //pickerView(_:didSelectRow:inComponent:)
        public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component].wrappedValue = row
        }
    }
}

struct MultiPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPickerView(data:
                            ["0 min", "1 min", "2 min",  "3 min",
                             "4 min", "5 min", "6 min",  "7 min",
                             "8 min", "9 min", "10 min", "11 min"],
                            ["0 sec", "1 sec", "2 sec",  "3 sec"],
                        selection: .constant(5), .constant(0))
    }
}
#endif

#if SKIP
import com.chargemap.compose.numberpicker.__
import androidx.compose.ui.text.__

// Kotlin for Android
struct MultiPickerView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let minutesRange: ClosedRange<Int>
    let secondsRange: ClosedRange<Int>
    
    @Binding var selectedTimeMin: Int
    @Binding var selectedTimeSec: Int
    
    var body: some View {
        HStack {
            ComposeView { _ in
                NumberPicker(
                    dividersColor: Colors.accentColor.asComposeColor(),
                    value: selectedTimeMin,
                    range: minutesRange.start..minutesRange.endInclusive,
                    onValueChange: {
                        selectedTimeMin = $0
                    },
                    textStyle: TextStyle(color: Color.primary.asComposeColor())
                )
            }
            Text("min")
            ComposeView { _ in
                NumberPicker(
                    dividersColor: Colors.accentColor.asComposeColor(),
                    value: selectedTimeSec,
                    range: secondsRange.start..secondsRange.endInclusive,
                    onValueChange: {
                        selectedTimeSec = $0
                    },
                    textStyle: TextStyle(color: Color.primary.asComposeColor())
                )
            }
            Text("sec")
        }
    }
}
#endif
