import SwiftUI
import shared
import Combine
import Foundation

struct ContentView: View {
    @State var user = ""
    @State var pass = ""
    @State var login = false
    @State var signup = false
    @EnvironmentObject private var login_manger : LoginRequset
    @EnvironmentObject private var Singup_manger : SingUpRequset
    var body: some View {
        NavigationView {
        ZStack {
            
            LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Login(login: $login, signup: $signup, user: $user, pass: $pass, manger: _login_manger)

        }
        .alert(isPresented: $login){
            
            Alert(title: Text(self.user), message: Text(self.pass), dismissButton: .none)
        }
    }
    }
        
}

struct InputTextField : View {
    @Binding var bindingText : String
    let image : String
    let placeholder : String
    let secureTextField : Bool
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Image(systemName: image)
                    .resizable()
                    .frame(width: 20, height: 20)
                if secureTextField {
                    SecureField(placeholder, text: $bindingText)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .padding(12)
                        .background(Color("Color"))
                        .cornerRadius(20)
                    
                }
                else{
                    TextField(placeholder, text: $bindingText)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .padding(12)
                        .background(Color("Color"))
                        .cornerRadius(20)
                }

                
            }
            
        }
     }
    
}

struct Login : View {
    
    @Binding var login : Bool
    @Binding var signup : Bool
    @Binding var user : String
    @Binding var pass : String
    @EnvironmentObject var manger : LoginRequset
    @State var isInGelogd : Bool = false
       var body : some View{
        

        NavigationView{
            ZStack {
                LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {

            
            if self.manger.authenticated {
                Text("correct").font(.headline)
                
            }

        Image("logo").resizable().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding(.bottom, 10)
       
        InputTextField(bindingText: $user, image: "person.fill", placeholder : "Username" , secureTextField : false)
        InputTextField(bindingText: $pass, image: "lock.fill", placeholder : "Password" , secureTextField : true)
        
        NavigationLink(destination:             home(), isActive: $isInGelogd){
            
            Button(action: {

                self.manger.postAuth(username: self.user, password: self.pass)
                
            }
            
            )
            {
                
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                
            }
            .background(LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: .leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing))
            .cornerRadius(20)
            .shadow(radius: 25)
                    
                
            }

            
        Button(action: {
            
        }) {
        
            Text("Forgot password?")
                .foregroundColor(.white)
        }
        
        VStack {
            Text("Dont have account yet").foregroundColor(.white)
            
            NavigationLink(destination:                         signUp(signup : self.$signup, login: $login), isActive: $signup){
                
                Button(action: {
                    
                    self.signup = true
                    
                    
                }) {
                    
                    Text("SigUp")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                    
                }
                .background(LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: .leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing))
                .cornerRadius(20)
                .shadow(radius: 25)

            }.padding(.top, 35)
            }
           
        
        
})
.padding(.horizontal, 18)
        
        
    }
       
        }
        
       }
    
}

struct signUp :View {
    @Binding var signup : Bool
    @State var email : String = ""
    @State var user : String = ""
    @State var pass : String = ""
    @State var repass : String = ""
    @Binding var login : Bool
    @EnvironmentObject var loginManger : LoginRequset
    @EnvironmentObject var manger : SingUpRequset
    
    @State var isAtive : Bool = false
    
    
    var body : some View{
        
            NavigationView{
                
                ZStack {
                    LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {
            
            Image("logo").resizable().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding(.bottom, 10)
            
            InputTextField(bindingText: $email, image: "envelope.circle.fill", placeholder : "Email" , secureTextField : false)
            
            InputTextField(bindingText: $user, image: "person.fill", placeholder : "Username" , secureTextField : false)
            
            InputTextField(bindingText: $pass, image: "lock.fill", placeholder : "Password" , secureTextField : false)
            
            InputTextField(bindingText: $repass, image: "lock.fill", placeholder : "RePassword" , secureTextField : false)
            
            NavigationLink(destination:             Login(login: $login, signup: $signup, user: $user, pass: $pass, manger: _loginManger), isActive: $isAtive){
           
                Button(action: {
                    
                    
                    manger.postAuth(email: email, username: user, password: pass)
                    
                    self.isAtive = true
                    
                }) {
                    
                    Text("SignUP")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                    
                }
                .background(LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: .leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing))
                .cornerRadius(20)
                .shadow(radius: 25)
            }
        

    })
    .padding(.horizontal, 18)
        }
        }
        
        
        
    }
    
    
   
}

struct home : View {
    
    var body : some View{
        ZStack {
    LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {

            Image("logo").resizable().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding(.bottom, 10)

        }
    
    )}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}

