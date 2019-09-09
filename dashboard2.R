vv=c(168807,77244,54552,41792,35509,16532,11067,147085,95975,46132,50199,46619,29153,
     19934,127095,85118,45611,56216,55794,25621,21514)

M=matrix(vv,nrow=3,ncol=7,byrow=T)
colnames(M)=c("違規停車","違規停車拖吊","闖紅燈直行左轉","行車速度超速60公里以下","不依規定轉彎或變換車道","未戴安全帽","其他不遵守標誌標線號誌駕車"
)
row.names(M)=c("105","106","107")

v=c(127095,85118,56216,55794,45611,25621,21514,19643,16522,16522,7497,
    5313,4738,4029,3993,3836,2466,2371,2073,1769,1730,1504,1226,1171,
    975,912,883,866,787,763,469,459,459,431,403,396,345,333,296,268,211,
    186,186,152,143,130,109,88,83,73,71,53,49,46,38,38,35,30,28,28,22,22,
    21,19,18,12,10,10,6,3,2,2,2,1,1,1,1)
M2=matrix(v,nrow=77,ncol=1)

colnames(M2)=c("freq")
row.names(M2)=c("違規停車","違規停車拖吊","闖紅燈直行左轉","行車速度超速60公里以下",
                "不依規定轉彎或變換車道","未戴安全帽","其他不遵守標誌標線號誌駕車",
                "闖紅燈右轉","爭道行駛","違規臨時停車","未領有駕照駕車",
                "酒精濃度超過規定標準者","停車時間位置方式車種不依規定",
                "於身心障礙專用停車位違規停車","在多車道不依規定駕車",
                "在多車道轉彎不依規定","其他汽機車違規未列之","設備不全或損壞不予修復",
                "駕照不合規定者","併排停車","越級駕駛","直行車佔用轉彎專用車道",
                "行駛道路以手持方式使用行動電話","未領用或未懸掛牌照等","五年內二次以上酒駕違規者",
                "不按遵行方向行駛","違反高快速公路管制規定","不依規定超車",
                "未繫安全帶","違反道安規則管制規則肇事致人受傷","違規車輛移置保管車輛移置保管",
                "未領用有效牌照、懸掛他車或未懸掛號牌停車","駕車吸菸致影響他人行車安全",
                "裝載超過核定之總重量總聯結重量者","吸食毒品迷幻藥麻醉品及其相類似之管制藥品者",
                "拒絕接受酒精或管制藥品之檢測","肇事致人傷亡而逃逸者",
                "肇事無人傷亡未依規定處理而逃逸者","駕照吊扣期間駕駛","機踏車附載人員或物品未依規定",
                "汽車所有人提供汽車駕駛人危險駕車","行車速度超過規定之最高時速60公里",
                "不服或抗拒交通警察人員取締","不依規定辦理異動申請或年度查驗者",
                "牌照遺失或破損不報請補發","未辦理執業登記","載運客貨違反規定",
                "行駛道路使用電腦或其他相類功能裝置","行經行人穿越道不暫停讓行人先行",
                "報廢汽車仍行駛","重要設備變更或因事故損壞未檢驗而行駛","肇事無人傷亡不將車輛移置路邊",
                "肇事致人死傷未依規定處置","蛇行或危險駕車","損毀或變造牌照致不能辨認牌號",
                "路口淨空","設有劃分島在慢車道右轉彎或在快車道左轉彎",
                "未依規定減速慢行","裝載不合規定","執業登記證未依規定安置等",
                "行經警察機關設有告示執行酒測勤務處所不依指示停車接受稽查",
                "以迫近驟然變換車道或不當方式迫使他車讓道",
                "拼裝車輛違規行駛","行駛中任意驟然減速煞車或暫停",
                "轉彎不暫停讓行人優先通行","大型車駕照不合規定者","二輛以上競駛競技",
                "在道路上停放待售或承修之車輛","動力機械未請領臨時通行證",
                "大型車駕照吊扣期間駕車","各項異動不依規定申報登記",
                "裝載砂石土方未依規定使用專用車輛","附載幼童未依規定安置於安全椅",
                "大型車未領有駕照駕車","汽車裝載貨物行經設有地磅處所1公里內拒絕過磅",
                "非屬汽車之載具動力休閒器材違規行駛","拆除消音器或以其他方式製造噪音")



library(shiny)
library(shinydashboard)
library(wordcloud)

ui <- dashboardPage(
    dashboardHeader(title = "台南紅燈裝飾用？？"),
    dashboardSidebar(
        sidebarMenuOutput("menu")
        
    ),
    dashboardBody(
        titlePanel("近三年次數比較"),
        
        # Generate a row with a sidebar
        sidebarLayout(      
            
            # Define the sidebar with one input
            sidebarPanel(
                selectInput("item", "Item:", 
                            choices=colnames(M)),
                hr(),
                helpText("資料來源：台南市政府資料開放平台")
            ),
            
            # Create a spot for the barplot
            mainPanel(
                plotOutput("yearsplot")  
            )
            
        ),
         titlePanel("107年各項違規次數"),
           
           sidebarLayout(
               # Sidebar with a slider and selection inputs
               sidebarPanel(
                   sliderInput("minfreq",
                               "Minimum Frequency:",
                               min = 0,  max = 25000, step = 2000,value = 20000)
               ),
               
               # Show Word Cloud
               mainPanel(
                   plotOutput("plot")
               )
           )

        )
        
)

server <- function(input, output,session) {
    output$menu <- renderMenu({
        sidebarMenu(
            menuItem("違規", icon = icon("star"))
        )
    })
    terms <- reactive(M2)
    
    # Make the wordcloud drawing predictable during a session
    output$yearsplot <- renderPlot({
        
        # Render a barplot
        barplot(M[,input$item], 
                main=input$item,
                ylab="違規次數",
                xlab="近三年",col = "navy")
    }) 
    wordcloud_rep <- repeatable(wordcloud)
    output$plot <- renderPlot({
        v <- terms()
        wordcloud_rep(rownames(M2), M2, scale=c(4,0.2),random.order=F,ordered.colors=F,
                      rot.per = FALSE,
                      min.freq = input$minfreq ,
                      colors=brewer.pal(8, "Spectral"))
    })
    
    
   
}

shinyApp(ui, server)