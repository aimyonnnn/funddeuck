package com.itwillbs.test.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.NotificationService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.ChartDataVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.NotificationVO;
import com.itwillbs.test.vo.PageInfoVO;
import com.itwillbs.test.vo.PaymentVO;

@Controller
public class AdminController {
	
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MakerService makerService;
	
	// 관리자 메인
	@GetMapping("admin")
	public String adminMain(HttpSession session, Model model) {
		return "admin/admin_main";
	}
	
	// 관리자 프로젝트
	@GetMapping("adminProject")
	public String adminProject(Model model) {
		
		
		
		
		return "admin/admin_project";
	}
	
	// 관리자 메시지
	@GetMapping("adminMessage")
	public String adminMessage(
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {

		System.out.println("검색타입 : " + searchType);
		System.out.println("검색어 : " + searchKeyword);
		// -------------------------------------------------------------------------
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// -------------------------------------------------------------------------
		// notificationService - getTotalList() 메서드 호출하여 게시물 목록 조회 요청
		// => 파라미터 : 검색타입, 검색어, 시작행번호, 목록갯수
		// => 리턴타입 : List<NotificationVO>(nList)
		List<NotificationVO> nList = notificationService.getTotalList(searchType, searchKeyword, startRow, listLimit);
		// -------------------------------------------------------------------------
		// 페이징 처리를 위한 계산 작업
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		// 1. notificationService - getNotificationListCount() 메서드를 호출하여
	//	    전체 게시물 수 조회 요청(페이지 목록 계산에 활용)
		// => 파라미터 : 검색타입, 검색어   리턴타입 : int(listCount)
		int listCount = notificationService.getNotificationListCount(searchType, searchKeyword);
	//			System.out.println("전체 게시물 수 : " + listCount);
	
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
	
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
	//			System.out.println("전체 페이지 목록 갯수 : " + maxPage);
	
		// 4. 시작 페이지 번호 계산 // 기댓값
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// (1 - 1) / 10 * 10 + 1 => 1
		// (2 - 1) / 10 * 10 + 1 => 1
		// (10 - 1) / 10 * 10 + 1 => 1
		// ...
		// (11 - 1) / 10 * 10 + 1 => 11
	//			System.out.println(startPage);
	
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
	
		// 6. 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다
	//	    클 경우 끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
	//			System.out.println(endPage);
	
		// 페이징 처리 정보를 저장할 PageInfoVO 객체에 계산된 데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		// -----------------------------------------------------------------------------------------
		// 조회된 게시물 목록 객쳬(boardList) 와 페이징 정보 객체(pageInfo) 를 Model 객체에 저장
		model.addAttribute("nList", nList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_notification_list";
	}
	
	// 페이지 로드 시 불러오는 차트
	@GetMapping("adminChart")
	public String adminChart(HttpSession session, Model model) {
	    System.out.println("adminChart");

	    // 메이커별 지난 7일간 전체 결제 금액
	    List<PaymentVO> payList = paymentService.getPaymentTotalWeekRange();
	    // 메이커별 지난 7일간 등록된 전체 서포터 수
	    List<PaymentVO> supporterList = paymentService.getSupporterCountWeekRange();

	    // Gson 객체 생성
	    Gson gson = new Gson();

	    // JsonArray 객체 생성
	    JsonArray payArray = new JsonArray(); // 결제 금액
	    JsonArray supporterArray = new JsonArray(); // 서포터 수

	    // 변수 초기화
	    int totalAmount = 0; // 누적 결제 금액
	    int todayAmount = 0; // 오늘 결제 금액
	    int totalSupporterCount = 0; // 누적 서포터 수
	    int todaySupporterCount = 0; // 오늘 등록한 서포터 수

	    // payList에서 하나씩 꺼내서 JsonObject를 생성하고 payArray에 추가
	    for (PaymentVO pay : payList) {
	        JsonObject object = new JsonObject();
	        object.addProperty("date", pay.getDate());
	        object.addProperty("amount", pay.getAmount());
	        payArray.add(object);

	        // 누적 결제 금액 계산
	        totalAmount += pay.getAmount();

	        // 오늘 결제 금액 계산 (오늘 날짜와 일치하는 경우)
	        LocalDate today = LocalDate.now();
	        LocalDate paymentDate = LocalDate.parse(pay.getDate());
	        if (today.isEqual(paymentDate)) {
	            todayAmount += pay.getAmount();
	        }
	    }

	    // supporterList에서 하나씩 꺼내서 JsonObject를 생성하고 supporterArray에 추가
	    for (PaymentVO supporter : supporterList) {
	        JsonObject object = new JsonObject();
	        object.addProperty("date", supporter.getDate());
	        object.addProperty("supporterCount", supporter.getCount());
	        supporterArray.add(object);

	        // 누적 서포터 수 계산
	        totalSupporterCount += supporter.getCount();

	        // 오늘 등록한 서포터 수 계산 (오늘 날짜와 일치하는 경우)
	        LocalDate today = LocalDate.now();
	        LocalDate registrationDate = LocalDate.parse(supporter.getDate());
	        if (today.isEqual(registrationDate)) {
	            todaySupporterCount += supporter.getCount();
	        }
	    }

	    // json 문자열로 변환 후 Model에 저장
	    String payListAmount = gson.toJson(payArray);
	    String supporterListCount = gson.toJson(supporterArray);
	    model.addAttribute("payListAmount", payListAmount);
	    model.addAttribute("todayAmount", todayAmount); // 오늘 결제 금액
	    model.addAttribute("totalAmount", totalAmount); // 누적 결제 금액
	    model.addAttribute("supporterListCount", supporterListCount); // 지난 7일간 등록된 전체 서포터 수
	    model.addAttribute("totalSupporterCount", totalSupporterCount); // 누적 서포터 수
	    model.addAttribute("todaySupporterCount", todaySupporterCount); // 오늘 등록한 서포터 수

	    return "admin/admin_chart";
	}

	
	// 시작일, 종료일 지정 시 나타나는 차트
	@GetMapping("/chartData2")
    @ResponseBody
    public ChartDataVO getChartData(
    		@RequestParam String startDate, @RequestParam String endDate, Model model) {
        // 날짜 형식을 지정하는 DateTimeFormatter 객체 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 시작일과 종료일을 파싱하여 LocalDate 객체로 변환
        LocalDate parsedStartDate = LocalDate.parse(startDate, formatter);
        LocalDate parsedEndDate = LocalDate.parse(endDate, formatter);
        System.out.println("parsedStartDate : " + parsedStartDate);
        System.out.println("parsedEndDate : " + parsedEndDate);

        // 전체 메이커별 결제 금액 조회
        List<PaymentVO> paymentList = paymentService.getTotalPayment(parsedStartDate, parsedEndDate);

        // 전체 메이커별 서포터 수 조회
        List<PaymentVO> supporterList = paymentService.getTotalSupporter(parsedStartDate, parsedEndDate);

        // 차트에 사용될 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 저장할 리스트 초기화
        List<String> labels = new LinkedList<>();
        List<Integer> dailyPaymentAmounts = new LinkedList<>();
        List<Integer> cumulativePaymentAmounts = new LinkedList<>();
        List<Integer> dailySupporterCounts = new LinkedList<>();
        List<Integer> cumulativeSupporterCounts = new LinkedList<>();

        int cumulativePaymentAmount = 0;
        int cumulativeSupporterCount = 0;

        // paymentList에서 하나씩 꺼내면서 리스트에 저장
        for (PaymentVO payment : paymentList) {
            String dateString = payment.getDate(); // 변경된 컬럼명인 'date'를 사용
            labels.add(dateString); // 라벨에 날짜 추가
            cumulativePaymentAmount += payment.getAmount(); // 누적 결제 금액 계산
            dailyPaymentAmounts.add(payment.getAmount()); // 일별 결제 금액 추가
            cumulativePaymentAmounts.add(cumulativePaymentAmount); // 누적 결제 금액 추가
        }

        int supporterIndex = 0; // 서포터 수 데이터 인덱스

        for (String label : labels) {
            if (supporterIndex < supporterList.size()) {
                PaymentVO supporterData = supporterList.get(supporterIndex);
                String dateString = supporterData.getDate(); // 변경된 컬럼명인 'date'를 사용

                if (label.equals(dateString)) {
                    cumulativeSupporterCount += supporterData.getCount(); // 누적 서포터 수 갱신
                    cumulativeSupporterCounts.add(cumulativeSupporterCount); // 누적 서포터 수 추가
                    dailySupporterCounts.add(supporterData.getCount()); // 일별 서포터 수 추가
                    supporterIndex++; // 다음 서포터 수 데이터로 이동
                    continue;
                }
            }
            dailySupporterCounts.add(0); // 누락된 날짜에 대해 0으로 처리된 일별 서포터 수 추가
            cumulativeSupporterCounts.add(cumulativeSupporterCount); // 이전의 누적 서포터 수 추가 (이전 데이터를 그대로 사용)
        }

        // ChartDataVO 객체를 생성하여 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 담아 반환
        return new ChartDataVO(labels, dailyPaymentAmounts, cumulativePaymentAmounts, dailySupporterCounts, cumulativeSupporterCounts);
    }
	
	
	
	
}
