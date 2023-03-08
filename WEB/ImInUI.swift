//
//  ImInUI.swift
//  WEB
//
//  Created by Александр Алексеев on 08.03.2023.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var uiImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var isShown: Bool
        @Binding var uiImage: UIImage?

        init(isShown: Binding<Bool>, uiImage: Binding<UIImage?>) {
            _isShown = isShown
            _uiImage = uiImage
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            uiImage = imagePicked
            isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, uiImage: $uiImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}

struct LibraryImage: View {

    @State var showAction: Bool = false
    @State var showImagePicker: Bool = false

    @State var uiImage: UIImage? = nil

    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            buttons: [
                .default(Text("Change"), action: {
                    self.showAction = false
                    self.showImagePicker = true
                }),
                .cancel(Text("Close"), action: {
                    self.showAction = false
                }),
                .destructive(Text("Remove"), action: {
                    //print(uiImage?.pngData()?.base64EncodedData(options: .endLineWithLineFeed))
                    self.showAction = false
                    self.uiImage = nil
                })
            ])

    }


    var body: some View {
        VStack {

            if (uiImage == nil) {
                Image(systemName: "camera.on.rectangle").resizable().scaledToFit().foregroundColor(.black)
                    .accentColor(.blue).background(.white).frame(width: 50, height: 50)
                    .onTapGesture {
                        self.showImagePicker = true
                    }
            } else {
                Image(uiImage: uiImage!)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .onTapGesture {
                        self.showAction = true
                    }
            }

        }

        .sheet(isPresented: $showImagePicker, onDismiss: {
            self.showImagePicker = false
        }, content: {
            ImagePicker(isShown: self.$showImagePicker, uiImage: self.$uiImage)
        })

        .actionSheet(isPresented: $showAction) {
            sheet
        }
        
    }
}


struct ImInUI: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImInUI_Previews: PreviewProvider {
    static var previews: some View {
        LibraryImage()
    }
}
