#ifndef __cplusLoggerGlobal_h__
#define __cplusLoggerGlobal_h__
//** CplusLoggerGlobal *******************************************************

#include <exception>

#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__)

#define NOMINMAX
#define PATH_SEPARATOR "\\"

#include <windows.h>
#include <string>

inline std::string kNowTime()
{
	const int MAX_LEN = 200;
	char buffer[MAX_LEN];
	if (GetTimeFormatA(LOCALE_USER_DEFAULT, 0, 0,
		"HH':'mm':'ss", buffer, MAX_LEN) == 0)
		return "Error in NowTime()";

	char result[100] = { 0 };
	static DWORD first = GetTickCount();

	std::sprintf(result, "%s.%03ld", buffer, (long)(GetTickCount() - first) % 1000);
	return result;
}

#else
#include <sys/time.h>

#define PATH_SEPARATOR "/" 
inline std::string kNowTime()
{
	char buffer[11];
	time_t t;
	time(&t);
	tm r = { 0 };
	strftime(buffer, sizeof(buffer), "%X", localtime_r(&t, &r));
	struct timeval tv;
	gettimeofday(&tv, 0);
	char result[100] = { 0 };
	std::sprintf(result, "%s.%03ld", buffer, (long)tv.tv_usec / 1000);
	return result;
}

#endif //defined(WIN32) || defined(_WIN32) || defined(__WIN32__)

//** CplusLoggerGlobal *******************************************************
#endif //__cplusLoggerGlobal_h__