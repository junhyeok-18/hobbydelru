package kr.co.vo;

public class SearchCriteria extends Criteria{

	private String kn_code = "";
	private String searchType = "";
	private String keyword = "";
	 
	public String getKn_code() {
		return kn_code;
	}
	public void setKn_code(String kn_code) {
		this.kn_code = kn_code;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "SearchCriteria [kn_code =" + kn_code + ", searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
}
