param([string]$url="192.168.1.120")
do{
    $HTTP_Request = [System.Net.WebRequest]::Create("http://$($url)");
    $HTTP_Request.GetResponse().StatusCode;
    start-sleep -s 30;
}until(!$?)