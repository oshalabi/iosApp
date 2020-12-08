import SwiftUI
import shared
import Combine
import Foundation

struct ContentView: View {
    @State var user = "blipblop"
    @State var pass = "Purevil@22"
    @State var login = false
    @State var signup = false
    @EnvironmentObject private var Login_manger : LoginRequset
    @EnvironmentObject private var Singup_manger : SingUpRequset
    
    @State var nogGeenAccount = false
    
    var body: some View {
        NavigationView {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if self.Login_manger.authenticated {
                home(user: self.$user)
            }
            if nogGeenAccount {
                signUp(signup : $signup, login: $login)
                
            }
            else {
                Login(login: login, signup: $signup, user: $user, pass: $pass, manger: self._Login_manger)

        }
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

struct Logo : View {

    var body: some View{
        Image("logo").resizable().frame(width: 100, height: 100).padding(.init(top: -50, leading: 0,  bottom: 8, trailing: 0))
    }
}

struct Login : View {
    
    @State var login : Bool
    @Binding var signup : Bool
    @Binding var user : String
    @Binding var pass : String
    @EnvironmentObject var manger : LoginRequset
    @EnvironmentObject var sinManger : SingUpRequset
    
       var body : some View{
        

        NavigationView{
            ZStack {
                LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {

        if manger.authenticated{
            home(user: $user)
            
        }
        Logo()
       
        InputTextField(bindingText: $user, image: "person.fill", placeholder : "Username" , secureTextField : false)
        InputTextField(bindingText: $pass, image: "lock.fill", placeholder : "Password" , secureTextField : true)
        
        NavigationLink(destination:
                        home(user: $user) ,isActive: self.$login )
                        {
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
            
        NavigationLink(destination:
                        signUp(signup : self.$signup, login: $login) ,isActive: $signup){
            
        Button(action: {
            
            
            self.signup = true
            
        }) {
        
            Text("Forgot password?")
                .foregroundColor(.white)
        }
                        }
        VStack {
            Text("Dont have account yet").foregroundColor(.white)
        }
        VStack{
            NavigationLink(destination:
                            signUp(signup : self.$signup, login: $login) ,isActive: $signup){
               
                Button(action: {
                    self.login = false
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
    
    
    
    var body : some View{
        
            NavigationView{
                
                ZStack {
                    LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {
            
            Logo()
            
            InputTextField(bindingText: $email, image: "envelope.circle.fill", placeholder : "Email" , secureTextField : false)
            
            InputTextField(bindingText: $user, image: "person.fill", placeholder : "Username" , secureTextField : false)
            
            InputTextField(bindingText: $pass, image: "lock.fill", placeholder : "Password" , secureTextField : false)
            
            InputTextField(bindingText: $repass, image: "lock.fill", placeholder : "RePassword" , secureTextField : false)
            
            NavigationLink(destination:             Login(login: login, signup: $signup, user: $user, pass: $pass, manger: _loginManger), isActive: $login ){
           
                Button(action: {
                    
                    
                    manger.postAuth(email: email, username: user, password: pass)
                    
                    self.login = true
                    self.signup = false
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
    @Binding var user : String
    var body : some View{
        
        NavigationView{
            
           ZStack {
           LinearGradient(gradient: .init(colors: [Color("1"),Color("2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 22, content: {
            
                Image("logo").resizable().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).padding(.bottom, 10)
            
                        })
            NavigationLink("profile", destination: Profile(user: $user))
            
           }
            
        }
    }
}

struct Profile : View {
    @Binding var user : String
    
    var body : some View{
        NavigationView{
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}

